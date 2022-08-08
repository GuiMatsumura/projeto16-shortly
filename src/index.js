import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

import userRouter from './routes/userRouter.js';
import urlRouter from './routes/urlRouter.js';

const app = express();
app.use(cors());
app.use(express.json());
dotenv.config();

app.use(userRouter);
app.use(urlRouter);

const port = process.env.PORT || 5002;
app.listen(port, () => {
  console.log('Server running on port ' + process.env.PORT);
});
