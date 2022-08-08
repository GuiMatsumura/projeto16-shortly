import connection from '../db/psqlStrategy.js';
import joi from 'joi';
import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid';

export async function postSignup(req, res) {
  console.log('entrei aqui');
  const user = req.body;
  const userSchema = joi.object({
    name: joi.string().required(),
    email: joi.string().email().required(),
    password: joi.required(),
    confirmPassword: joi.ref('password'),
  });

  const { error } = userSchema.validate(user);

  if (error) {
    res.status(422).send(error);
    return;
  }

  try {
    const { rows: exist } = await connection.query(
      'SELECT * FROM users WHERE email = $1',
      [user.email]
    );
    if (exist.length !== 0) {
      res.sendStatus(409);
      return;
    }

    const passwordHash = bcrypt.hashSync(user.password, 10);

    await connection.query(
      'INSERT INTO users (name, email, password) VALUES ($1, $2, $3)',
      [user.name, user.email, passwordHash]
    );
    res.sendStatus(201);
  } catch (err) {
    res.status(500).send(err);
    return;
  }
}

export async function postSignin(req, res) {
  const user = req.body;
  const userSchema = joi.object({
    email: joi.string().email().required(),
    password: joi.required(),
  });

  const { error } = userSchema.validate(user);
  if (error) {
    res.sendStatus(422);
    return;
  }

  try {
    const { rows: searchUser } = await connection.query(
      'SELECT * FROM users WHERE email = $1',
      [user.email]
    );
    if (searchUser.length === 0) {
      res.status(401).send('Email ou senha incorretos!');
      return;
    }
    const comparePassword = bcrypt.compareSync(
      user.password,
      searchUser[0].password
    );
    if (!comparePassword) {
      res.status(401).send('Email ou senha incorretos!');
      return;
    }
    const token = uuid();
    const id = searchUser[0].id;
    console.log(id);
    await connection.query(
      'INSERT INTO sections ("userId", token) VALUES ($1, $2)',
      [searchUser[0].id, token]
    );
    console.log('foi5');
    res.status(200).send(token);
  } catch (err) {
    res.status(500).send(err);
    return;
  }
}
