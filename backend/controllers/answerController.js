const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// get answer
const getAnswer = async (req, res) => {
  const { prompt } = req.query;

  try {
    const comments = await prisma.comments.findMany({
      where: {
        userType: "THERAPIST",
      },
    });

    const promptWords = new Set(prompt.toLowerCase().split(/\s+/));

    const matchingComments = comments.filter((comment) => {
      const commentWords = new Set(comment.comment.toLowerCase().split(/\s+/));
      const sharedWords = new Set(
        [...commentWords].filter((word) => promptWords.has(word))
      );
      return sharedWords.size >= 3 ? comment : null;
    });
    let answers = [];
    matchingComments.map((comment) => {
      console.log("khaii ta comment sir", comment.comment);
      answers.push(comment.comment);
    });
    res.status(200).json({ answers });
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

module.exports = { getAnswer };
