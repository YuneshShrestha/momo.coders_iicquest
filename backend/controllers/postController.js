const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// get all posts
const getAllPosts = async (req, res) => {
  try {
    const posts = await prisma.post.findMany();
    if (!posts) {
      return res.status(404).json({ error: "No posts found." });
    }
    res.status(200).json(posts);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// get single post
const getSinglePost = async (req, res) => {
  try {
    const { id } = req.params;
    console.log(id);
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
