const express=require("express");
const admin=require("../middlewares/admin")

const adminRouter=express.Router();


//adding product
adminRouter.post('admin/add-product',admin,async (req,res)=>{

    try{

    }catch(e){
        res.status(500).json({error:e.message})
    }
})


