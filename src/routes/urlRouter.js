import { Router } from 'express';
import {
  postUrl,
  getUrlId,
  getOpenUrl,
  getRanking,
  deleteUrl,
} from '../controllers/urlController.js';

const router = Router();

router.post('/urls/shorten', postUrl);
router.get('/urls/:id', getUrlId);
router.get('/urls/open/:shortUrl', getOpenUrl);
router.delete('/urls/:id', deleteUrl);
router.get('/ranking', getRanking);

export default router;
