const nodemailer = require('nodemailer');

module.exports = async (req, res) => {
  // CORS configuration
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed. Use POST.' });
  }

  try {
    let body = req.body;
    if (typeof body === 'string') {
      try {
        body = JSON.parse(body);
      } catch (e) {
        // use original
      }
    }

    const { name, email, message, subject } = body || {};

    if (!email || !email.trim()) {
      return res.status(400).json({ error: 'Please provide an email address.' });
    }

    if (!message || !message.trim()) {
      return res.status(400).json({ error: 'Please enter a message.' });
    }

    // Gmail configuration from Environment Variables
    const gmailUser = process.env.GMAIL_USER || 'kaziwoaej@gmail.com';
    const gmailAppPassword = process.env.GMAIL_APP_PASSWORD;

    if (!gmailAppPassword) {
      console.error('Missing GMAIL_APP_PASSWORD in environment variables');
      return res.status(500).json({
        error: 'Mailer not configured. Please set GMAIL_APP_PASSWORD in Vercel Environment Variables.'
      });
    }

    // Initialize Nodemailer transporter with Gmail
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: gmailUser,
        pass: gmailAppPassword,
      },
    });

    const senderName = name && name.trim() ? name.trim() : 'Portfolio Visitor';
    const mailSubject = subject && subject.trim()
      ? subject.trim()
      : `New Portfolio Message from ${senderName}`;

    await transporter.sendMail({
      from: `"${senderName}" <${gmailUser}>`,
      to: gmailUser,
      replyTo: email.trim(),
      subject: mailSubject,
      text: `Sender Name: ${senderName}\nSender Email: ${email.trim()}\n\nMessage:\n${message.trim()}`,
      html: `
        <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; max-width: 600px; margin: 0 auto; background-color: #ffffff; border: 1px solid #eaeaea; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
          <div style="background: linear-gradient(135deg, #007AFF 0%, #00C6FF 100%); padding: 24px 28px;">
            <h2 style="margin: 0; color: #ffffff; font-size: 20px; font-weight: 700; letter-spacing: -0.5px;">New Portfolio Contact Request</h2>
          </div>
          <div style="padding: 24px 28px;">
            <div style="margin-bottom: 20px;">
              <span style="font-size: 11px; text-transform: uppercase; color: #888888; font-weight: 700; letter-spacing: 1px;">Sender Information</span>
              <p style="margin: 6px 0 2px 0; font-size: 16px; font-weight: 600; color: #111111;">${senderName}</p>
              <p style="margin: 0; font-size: 14px; color: #007AFF;"><a href="mailto:${email.trim()}" style="color: #007AFF; text-decoration: none;">${email.trim()}</a></p>
            </div>
            <hr style="border: 0; border-top: 1px solid #f0f0f0; margin: 20px 0;" />
            <div style="margin-bottom: 20px;">
              <span style="font-size: 11px; text-transform: uppercase; color: #888888; font-weight: 700; letter-spacing: 1px;">Message</span>
              <div style="margin-top: 8px; background-color: #f8f9fa; border: 1px solid #e9ecef; border-radius: 8px; padding: 16px; font-size: 14px; line-height: 1.6; color: #333333; white-space: pre-wrap;">${message.trim()}</div>
            </div>
            <div style="font-size: 12px; color: #999999; margin-top: 24px; text-align: center;">
              Sent from your Portfolio Contact Form • Direct Reply-To is set to ${email.trim()}
            </div>
          </div>
        </div>
      `,
    });

    return res.status(200).json({ success: true, message: 'Message sent successfully!' });
  } catch (error) {
    console.error('Error sending email:', error);
    return res.status(500).json({ error: error.message || 'Failed to send email. Please try again later.' });
  }
};
