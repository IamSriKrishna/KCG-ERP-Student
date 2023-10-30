const FacultyModel = require("../../Model/Faculty");
const jwt = require("jsonwebtoken");
const invalidatedTokens = [];

const facultySignIn = async (req, res, next) => {
  try {
    const { rollno, password } = req.body;

    const faculty = await FacultyModel.findOne({ rollno });
    if (!faculty) {
      return res
        .status(400)
        .json({ msg: "faculty with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, faculty.password);
    if (isMatch !== true) {
      console.log(`${isMatch}\n${faculty.password}`);
      return res.status(400).json({ msg: "Incorrect password." });
    }

    const token = jwt.sign({ id: faculty._id }, "passwordKey", {
      algorithm: "HS256",
    });
    res.json({ token, ...faculty._doc });
  } catch (e) {
    next(error);
  }
};

const FacultySignUp = async (req, res, next) => {
  try {
    const { name, rollno, password, dp, department, year } = req.body;

    const existingFaculty = await FacultyModel.findOne({ rollno });

    if (existingFaculty) {
      return res
        .status(500)
        .json({ msg: "Faculty With Same Roll Number Already Exist!" });
    }

    if (!name || !rollno || !password || !dp || !department || !year) {
      return res.status(404).json({ msg: "All fields are mandatory" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
    let faculty = new FacultyModel({
      name,
      rollno,
      password: hashedPassword,
      dp,
      department,
      year,
    });
    faculty = await faculty.save();
    res.status(200).json({ msg: "Faculty Account Created" });
  } catch (error) {
    next(error); // Pass the error to the error handling middleware
  }
};

const FacultySignOut = (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(401).json({ msg: "No token provided" });
    }

    // Add the token to the blacklist
    invalidatedTokens.push(token);

    res.json({ msg: "You have been successfully signed out." });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

TokenValid = async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);

    // Check if the token is in the blacklist
    if (invalidatedTokens.includes(token)) {
      return res.json(false);
    }

    const verified = jwt.verify(token, "passwordKey");
    if (!verified) return res.json(false);

    const user = await FacultyModel.findById(verified.id);
    if (!user) return res.json(false);
    res.json(true);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { facultySignIn, FacultySignUp, FacultySignOut, TokenValid };
