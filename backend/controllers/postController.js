const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// get all posts
const getAllPosts = async (req, res) => {
  try {
    const postsWithComments = await prisma.post.findMany({
      include: {
        comments: true,
      },
    });

    const postsWithCommentCount = postsWithComments.map((post) => ({
      ...post,
      commentsCount: post.comments.length,
    }));

    if (postsWithCommentCount.length === 0) {
      return res.status(404).json({ error: "No posts found." });
    }
    res.status(200).json(postsWithCommentCount);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// get single post
const getSinglePost = async (req, res) => {
  try {
    console.log(req.params);
    const { id } = req.params;


    if (!id) {
      return res.status(400).json({ error: "Post id is required." });
    }

    const post = await prisma.post.findUnique({
      where: {
        id,
      },
    });
    console.log(post);

    if (!post) {
      return res.status(404).json({ error: "Post not found." });
    }
    res.status(200).json(post);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// create post
const createPost = async (req, res) => {
  try {
    const { title, description, userId, categoryId } = req.body;

    const existingPost = await prisma.post.findFirst({
      where: {
        AND: [{ title }, { description }],
      },
    });

    if (existingPost) {
      return res.status(409).json({
        error: "A post with the same title and description already exists.",
      });
    }

    const post = await prisma.post.create({
      data: {
        title,
        description,
        userId,
        categoryId,
      },
    });

    if (!post) {
      return res.status(404).json({ error: "Post not found." });
    }
    res.status(200).json(post);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// delete posts
const deletePosts = async (req, res) => {
  try {
    const posts = await prisma.post.deleteMany();
    if (!posts) {
      return res.status(404).json({ error: "No posts found." });
    }
    res.status(200).json(posts);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// delete single post
const deleteSinglePost = async (req, res) => {
  try {
    const { id } = req.params;

    if (!id) {
      return res.status(400).json({ error: "Post id is required." });
    }

    const post = await prisma.post.delete({
      where: {
        id: parseInt(id),
      },
    });

    if (!post) {
      return res.status(404).json({ error: "Post not found." });
    }
    res.status(200).json(post);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// update post
const updatePost = async (req, res) => {
  try {
    const { id } = req.params;
    if (!id) {
      return res.status(400).json({ error: "Post id is required." });
    }
    const { title, description } = req.body;
    const post = await prisma.post.update({
      where: {
        id,
      },
      data: {
        title,
        description,
      },
    });

    if (!post) {
      return res.status(404).json({ error: "Post not found." });
    }
    res.status(200).json(post);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

module.exports = {
  getAllPosts,
  getSinglePost,
  createPost,
  deletePosts,
  deleteSinglePost,
  updatePost,
};
