const jwt =require("jsonwebtoken")
const User = require("../models/user");
const admin=async(req,res,next) =>{
    try {
        const token = req.header('x-auth-token');
        
        // Check if token is present
        if (!token) {
            return res.status(401).json({ msg: "No authentication token, access denied!" });
        }
        
        // Verify token
        const decodedToken = jwt.verify(token, "passwordKey");
        if (!decodedToken) {
            return res.status(401).json({ msg: "Token verification failed, authentication denied!" });
        }

        const user= await User.findById(decodedToken.id);

        if(user.type=='user' || user.type=='seller') {
            return res.status(500).json({msg:"you are not an admin"})
        }
        // Attach user information to request
        req.user = decodedToken.id;
        req.token = token;
        next();

    } catch (e) {
        res.status(500).json({ error: e.message });
    };
}