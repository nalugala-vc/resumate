import * as nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'vanessachebukwa@gmail.com',
    pass: 'evddfimtfwcndtde',
  },
});

const mailOptions = {
  from: 'vanessachebukwa@gmail.com',
  to: 'venessa@savannah.tech',
  subject: 'Test Email from Nodemailer',
  text: 'If you receive this, email sending works 🎉',
};

transporter.sendMail(mailOptions, (error, info) => {
  if (error) {
    console.error('❌ Error sending email:', error);
  } else {
    console.log('✅ Email sent:', info.response);
  }
});
