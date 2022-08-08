import { Router } from 'express';
import { postSignup, postSignin } from '../controllers/userController.js';

const router = Router();

router.post('/signup', postSignup);
router.post('/signin', postSignin);

export default router;
