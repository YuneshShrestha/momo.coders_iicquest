const primsa = require("@prisma/client");

const prisma = new primsa.PrismaClient();

// get all categories
const getAllCategories = async (req, res) => {
  try {
    const categories = await prisma.category.findMany();
    if (!categories) {
      return res.status(404).json({ error: "No categories found." });
    }

    res.status(200).json(categories);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// get single category
const getSingleCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const category = await prisma.category.findUnique({
      where: {
        id,
      },
      include: {
        videos: true,
      },
    });

    if (!category) {
      return res.statu(404).json({ error: "Category not found." });
    }

    res.status(200).json(category);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// create a category
const createCategory = async (req, res) => {
  try {
    const { name } = req.body;
    const category = await prisma.category.create({
      data: {
        name,
      },
    });

    if (!category) {
      return res.status(404).json({ error: "Category not found." });
    }

    res.status(200).json(category);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// update category
const updateCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const { name } = req.body;

    const category = await prisma.category.update({
      where: {
        id,
      },
      data: {
        name,
      },
    });

    if (!category) {
      return res.status(404).json({ error: "Category not found." });
    }

    res.status(200).json(category);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// delete category
const deleteCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const category = await prisma.category.delete({
      where: {
        id,
      },
    });

    if (!category) {
      return res.status(404).json({ error: "Category not found." });
    }

    res.status(200).json(category);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// delete categories
const deleteCategories = async (req, res) => {
  try {
    const categories = await prisma.category.deleteMany();
    if (!categories) {
      return res.status(404).json({ error: "No categories found." });
    }
    res.status(200).json(categories);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

module.exports = {
  getAllCategories,
  getSingleCategory,
  createCategory,
  updateCategory,
  deleteCategory,
  deleteCategories,
};
