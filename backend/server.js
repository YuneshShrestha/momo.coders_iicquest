require("dotenv").config();
const express = require("express");
const postRoutes = require("./routes/post");
const categoryRoutes = require("./routes/category");
const videoRoutes = require("./routes/video");

const primsa = require("@prisma/client");

const prisma = new primsa.PrismaClient();

const app = express();

app.use(express.json());

// create comments
app.post("/api/comments", async (req, res) => {
  const { comment, postId, userId, userType } = req.body;
  try {
    const comments = await prisma.comments.create({
      data: {
        comment,
        postId,
        userId,
        userType,
      },
    });
    res.status(200).json(comments);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
});

// get comments by post
app.get("/api/posts/:postId/comments", async (req, res) => {
  const { postId } = req.params;
  try {
    const comments = await prisma.comments.findMany({
      where: {
        postId,
      },
    });
    res.status(200).json(comments);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
});

// get posts by category
app.get("/api/categories/:categoryId/posts", async (req, res) => {
  const { categoryId } = req.params;
  try {
    const posts = await prisma.post.findMany({
      where: {
        categoryId,
      },
    });
    res.status(200).json(posts);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
});

// Routes
app.use("/api/posts", postRoutes);
app.use("/api/categories", categoryRoutes);
app.use("/api/videos", videoRoutes);

const server = app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${process.env.PORT}`);
});
