import { Router } from 'express';
import { postSignup } from '../controllers/userController.js';

const router = Router();

router.post('/signup', postSignup);

export default router;