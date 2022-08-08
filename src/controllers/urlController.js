import connection from '../db/psqlStrategy.js';
import joi from 'joi';
import { nanoid } from 'nanoid';

export async function postUrl(req, res) {
  const header = req.headers.authorization;
  const url = req.body;
  const authorization = header.replace('Bearer ', '');

  const urlSchema = joi.object({
    url: joi.string().required(),
  });

  const { error } = urlSchema.validate(url);

  if (error) {
    res.sendStatus(422);
    return;
  }

  try {
    const { rows: section } = await connection.query(
      'SELECT * FROM sections WHERE token = $1',
      [authorization]
    );

    if (section.length === 0) {
      res.sendStatus(401);
      return;
    }

    const shortUrl = nanoid(10);

    const { rows: exist } = await connection.query(
      'SELECT * FROM "urlOriginal" WHERE url = $1',
      [url.url]
    );

    if (exist.length !== 0) {
      res.sendStatus(409);
      return;
    }

    await connection.query(
      'INSERT INTO "urlOriginal" (url, "userId") VALUES ($1, $2)',
      [url.url, section[0].userId]
    );

    const { rows: urlOriginal } = await connection.query(
      'SELECT * FROM "urlOriginal" WHERE url = $1',
      [url.url]
    );
    console.log(urlOriginal);
    console.log('aq');
    await connection.query(
      'INSERT INTO "urlShort" ("urlShort", "urlOriginalId", "visitCount") VALUES ($1, $2, 0)',
      [shortUrl, urlOriginal[0].id]
    );
    console.log('aq2');
    const { rows: shortenedUrl } = await connection.query(
      'SELECT "urlShort" AS "shortUrl" FROM "urlShort" WHERE "urlShort" = $1',
      [shortUrl]
    );
    res.status(201).send(shortenedUrl[0]);
  } catch (err) {
    res.status(500).send(err);
    return;
  }
}

export async function getUrlId(req, res) {
  const { id } = req.params;
  try {
    const { rows: searchUrl } = await connection.query(
      'SELECT "urlShort".id, "urlShort"."urlShort" AS "shortUrl", url FROM "urlShort" JOIN "urlOriginal" ON "urlOriginal".id = "urlShort"."urlOriginalId" WHERE "urlShort".id = $1',
      [id]
    );
    if (searchUrl.length === 0) {
      res.sendStatus(404);
      return;
    }
    res.status(200).send(searchUrl[0]);
  } catch (err) {
    res.status(500).send(err);
    return;
  }
}

export async function getOpenUrl(req, res) {
  const { shortUrl } = req.params;
  try {
    const { rows: searchUrl } = await connection.query(
      'SELECT * FROM "urlShort" WHERE "urlShort" = $1',
      [shortUrl]
    );
    if (searchUrl.length === 0) {
      res.sendStatus(404);
      return;
    }
    await connection.query(
      'UPDATE "urlShort" SET "visitCount" = $1 WHERE "urlShort" = $2',
      [searchUrl[0].visitCount + 1, shortUrl]
    );
    const { rows: urlOriginalId } = await connection.query(
      'SELECT "urlOriginalId" FROM "urlShort" WHERE "urlShort" = $1',
      [shortUrl]
    );
    const { rows: urlOriginal } = await connection.query(
      'SELECT url FROM "urlOriginal" WHERE id = $1',
      [urlOriginalId[0].urlOriginalId]
    );
    res.redirect(200, urlOriginal[0].url);
  } catch (err) {
    res.status(500).send(err);
    return;
  }
}

export async function deleteUrl(req, res) {
  const { id } = req.params;
  const header = req.headers.authorization;
  const authorization = header.replace('Bearer ', '');

  try {
    const { rows: section } = await connection.query(
      'SELECT * FROM sections WHERE token = $1',
      [authorization]
    );
    if (section.length === 0) {
      res.sendStatus(401);
      return;
    }

    const { rows: exist } = await connection.query(
      'SELECT * FROM "urlShort" WHERE "urlShort".id = $1',
      [id]
    );
    if (exist.length === 0) {
      res.sendStatus(404);
    }

    const { rows: urlShort } = await connection.query(
      'SELECT * FROM "urlShort" JOIN "urlOriginal" ON "urlOriginal".id = "urlShort"."urlOriginalId" WHERE "urlShort".id = $1',
      [id]
    );
    if (urlShort[0].userId !== section[0].userId) {
      res.sendStatus(401);
      return;
    }

    await connection.query('DELETE FROM "urlShort" WHERE id = $1', [id]);
    res.sendStatus(204);
  } catch (error) {
    res.status(500).send(err);
    return;
  }
}

export async function getRanking(req, res) {
  try {
    const { rows: ranking } = await connection.query(
      'SELECT users.id AS id, users.name AS name, "urlShort"."visitCount" AS "visitCount" FROM "urlShort" JOIN "urlOriginal" ON "urlOriginal".id = "urlShort"."urlOriginalId" JOIN users ON users.id = "urlOriginal"."userId" ORDER BY "visitCount" DESC LIMIT 10'
    );
    res.status(200).send(ranking);
  } catch (err) {
    res.status(500).send(err);
    return;
  }
}
