import { Db, MongoClient } from 'mongodb';
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';


const client = new MongoClient("mongodb://localhost:27017"); //or your MongoDB connection string
const dbName = 'your-db-name'; // Replace with your actual database name

const Users = {
    async add(username: string, email: string, password: string): Promise<any> {
        try {
            await client.connect();
            const db: Db = client.db(dbName);
            const collection = db.collection('users');

            const passwordHash = await bcrypt.hash(password, 10); // Hash the password

            const result = await collection.insertOne({ username, email, passwordHash });
            return result.insertedId;
        } finally {
            await client.close();
        }
    },

    async authenticate(usernameOrEmail: string, password: string): Promise<string | null> {
        try {
            await client.connect();
            const db: Db = client.db(dbName);
            const collection = db.collection('users');

            const user = await collection.findOne({ $or: [{ username: usernameOrEmail }, { email: usernameOrEmail }] });

            if (user && await bcrypt.compare(password, user.passwordHash)) {
                // Passwords match
                const token = jwt.sign({ userId: user._id, username: user.username }, "test-secret", { expiresIn: '1h' }); // Create JWT
                return token;
            } else {
                return null; // Authentication failed
            }
        } finally {
            await client.close();
        }
    },
    async list(): Promise<any[]> {
        try {
            await client.connect();
            const db: Db = client.db(dbName);
            const collection = db.collection('users');

            const users = await collection.find({}).toArray();
            return users;
        } finally {
            await client.close();
        }
    },
    async del(username: string): Promise<number> {
        try {
            await client.connect();
            const db: Db = client.db(dbName);
            const collection = db.collection('users');

            const result = await collection.deleteOne({ username: username });
            return result.deletedCount;
        } finally {
            await client.close();
        }
    }
};

export default Users;