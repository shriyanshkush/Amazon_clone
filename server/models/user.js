const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@(([^<>()[\]\\.,;:\s@"]+\.)+[^<>()[\]\\.,;:\s@"]{2,})$/i;
                return re.test(value);
            },
            message: 'Please enter a correct email'
        }
    },
    password:{
        required:true,
        type:String,
        validate: {
            validator: (value) => {
                return value.length >=8;
            },
            message: 'Please enter a long Password'
        }
    },
    address:{
        type:String,
        default:' ',
    },
    type:{
        type:String,
        default:'user',
    }
    //cart
}, { versionKey: false });

const User=mongoose.model("User", userSchema)

module.exports = User;
