require("dotenv").config();
const express = require("express");
const postRoutes = require("./routes/post");

const app = express();

app.use(express.json());

// Routes
app.use("/api/posts", postRoutes);

const server = app.listen(process.env.PORT, () => {
  console.log(`Server is running on port ${process.env.PORT}`);
});
