const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
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

        // Attach user information to request
        req.user = decodedToken.id;
        req.token = token;
        
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = auth;
