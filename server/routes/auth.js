const express = require('express');
const User = require("../models/user");
const bcrypt=require("bcryptjs");
const jwt=require("jsonwebtoken")
const auth=require("../middlewares/auth")

const authRouter = express.Router();

//signup route
authRouter.post("/api/signup", async (req, res) => {
    try {
        // Extract data from request
        const { name, email, password } = req.body;

        // Check if user with the same email already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with the same email already exists!" });
        }

        const hashPassword= await bcrypt.hash(password,8);
        //here 8 is salt not length of string.

        // Create a new user instance
        let user = new User({
            name,
            email,
            password:hashPassword,
        });

        // Save user to the database
        user = await user.save();

        // Return the newly created user
        res.status(201).json(user);
    } catch (error) {
        // Handle errors
        res.status(500).json({ msg: "Server error. Please try again later.", error: error.message });
    }
});

//signIn route:
authRouter.post("/api/signin",async (req,res)=>{
    try{
       const {email,password} =req.body;
       const user= await User.findOne({email});
       if(!user) {
        return res.status(400).json({msg:"user with this email does not exist"});
       }

       //password writen:125475 but in database gibbrish

       //if we first hash password using bcryptjs then compare then it will not going  to work because of that salt property,
       //because of salt no two password will be same.
       const isMatch =await bcrypt.compare(password,user.password);

       if(!isMatch) {
        return res.status(400).json({msg:"incorrect password"});
       }

       const token=jwt.sign({id:user._id},"passwordKey");
       res.json({token,...user._doc})
       //above part will give something like this i.e. add token property in user
       /*
       {
        "token":"tokensomething",
        "name":"shriyansh",
        "email":"rrr@google.com"
       }
        */
    }catch(e) {
        res.status(500).json({error:e.message});
    }
});

authRouter.post("/tokenIsValid",async (req,res)=>{
    try{
        const token=req.header('x-auth-token');
        if(!token) return res.json(false);
        const isVerified = jwt.verify(token,"passwordKey");
        if(!isVerified) {
            return res.json(false);
        }
        const user=await User.findById(isVerified.id);
        if(!user) {
            return res.json(false);
        }
        res.json(true);

    } catch(e) {
        res.status(500).json({error:e.message});
    }
});


//get user data

authRouter.get('/',auth,async(req,res)=>{
    const user =await User.findById(req.user);
    res.json({...user._doc,token:req.token})
})

module.exports = authRouter;



//json webtoken: