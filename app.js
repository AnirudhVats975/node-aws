import * as dotenv from "dotenv";
import express from "express";
import  {connectDB} from './config/db.js';
const app = express();
const PORT = process.env.PORT || 5000;
dotenv.config({ path: "./.env" });
import cookieParser from "cookie-parser";
connectDB();

app.use(express.json());
app.use(express.static("public"));
app.use(cookieParser());

import authRoutes from './routes/authRoutes.js';

app.use('/api/auth', authRoutes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
