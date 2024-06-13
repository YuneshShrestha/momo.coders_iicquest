const express = require("express");

const { getAnswer } = require("../controllers/answerController");

const router = express.Router();

router.get("/", getAnswer);

module.exports = router;
