
// using Twilio SendGrid's v3 Node.js Library
// https://github.com/sendgrid/sendgrid-nodejs

// const sgMail = require('@sendgrid/mail');

// // Set SendGrid API key
// sgMail.setApiKey(process.env.SENDGRID_API_KEY);


async function sendEmail_toUser(username, room_num, room_hall, email, first, last) {

  //const sgMail = require('@sendgrid/mail');

  // Set SendGrid API key
  // sgMail.setApiKey('Enter API Key Here');

  const msg = {
    to: email, // Change to your recipient
    from: 'jmustudyhalls@gmail.com', // Change to your verified sender
    subject: `${username}, ${room_hall} ${room_num} Opening`,
    html: `<p><strong>James Madison University</strong></p> 
          <br><p>Hello ${first} ${last}, 
          <br>${room_hall} ${room_num} is open and ready for use.
          <br><br> For more information, go to jmustudyroom.com.</p>      
          <br><br><br><img src="https://www.jmu.edu/jmucmsfiles/images/rwd-footer/jmu-logo-grey-2018.png" alt="School Logo" />
          <br><br><p>This is an automated message. Do not reply to this email.</p>
    `,
  };


  // Send email
  sgMail
    .send(msg)
    .then(() => {
      console.log('Email sent');
    })
    .catch((error) => {
      console.error(error);
    });

}

// sendEmail_toUser();

module.exports = { sendEmail_toUser };
