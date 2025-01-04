//IMPORT FROM PACAGES
const express=require("express");
const mongoose=require("mongoose");

//IMPORTS FROM FILES
const authRouter=require('./routes/auth.js');
const adminRouter=require('./routes/admin.js');
const productRouter=require('./routes/product.js')
const userRouter=require('./routes/user.js')
//const admin=require('./middlewares/admin.js');


//INIT
const port= process.env.PORT || 3000;
const app=express();
const DB="mongodb+srv://Shriyansh:Shriyansh123@cluster0.gx7tm.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

//middleware
//CLIENT DATA-> MIDDLEWARE -> SERVER DATA ->CLIENT DATA
app.use(express.json())
app.use(authRouter);
app.use(adminRouter);
//app.use(admin); this cause an error and leads to not work of product fetch api
app.use(productRouter);
app.use(userRouter);
//connection to database
mongoose.connect(DB).then(()=>{
    console.log("connection succesfull");
})
.catch((e)=>{
    console.log(`connection faild: ${e}`);
})

//creating an api
//api have Get, Post, Delete, Update
//get
// "http://<your ip adress>/helloWorld
//app.get('/',(req,res)=>{
//res.send({name:"Shriyansh"});
//});

app.listen(port,"0.0.0.0", () => {
console.log(`connected at port : ${port} hello`)
});



//install nodemon so that you dont need to start server again and again.
