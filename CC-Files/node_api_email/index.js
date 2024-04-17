
// using Twilio SendGrid's v3 Node.js Library
// https://github.com/sendgrid/sendgrid-nodejs

const e = require('express');

// const sgMail = require('@sendgrid/mail');

// // Set SendGrid API key
// sgMail.setApiKey(process.env.SENDGRID_API_KEY);


async function sendEmail_toUser(username, room_num, room_hall, email, first, last) {

  const sgMail = require('@sendgrid/mail');

  // Set SendGrid API key
  sgMail.setApiKey('Enter API HERE');

  const currentDate = new Date();
  const date = currentDate.getDate();
  const day = currentDate.getDay();
  const hour = currentDate.getHours();
  const minute = currentDate.getMinutes();
  const month = currentDate.getMonth();

  let day2 = '';
  switch(day) {
    case 0:
      day2 = 'Sun';
      break;
    case 1:
      day2 = 'Mon';
      break;
    case 2:
      day2 = 'Tues';
      break;
    case 3:
      day2 = 'Wed';
      break;
    case 4:
      day2 = 'Thu';
      break;
    case 5:
      day2 = 'Fri';
      break;
    case 6:
      day2 = 'Sat';
      break
    default:
      break;
  }

  let month2 = '';
  switch (month) {
    case 0:
      month2 = 'Jan';
      break;
    case 1:
      month2 = 'Feb';
      break;
    case 2:
      month2 = 'Mar';
      break;
    case 3:
      month2 = 'Apr';
      break;
    case 4:
      month2 = 'May';
      break;
    case 5:
      month2 = 'June';
      break;
    case 6:
      month2 = 'July';
      break;
    case 7:
      month2 = 'Aug';
      break;
    case 8:
      month2 = 'Sep';
      break;
    case 9:
      month2 = 'Oct';
      break;
    case 10:
      month2 = 'Nov';
      break;
    case 11:
      month2 = 'Dec';
      break; 
  }

  let timeFrame = '';
  if (hour >= 12) {
    timeFrame = 'pm';
  } else {
    timeFrame = 'am';
  }

  let hour2 = '';
  if (hour > 0 && hour <= 12) {
    hour2 = '' + hour;
  } else if (hour > 12) {
    hour2 = '' + (hour - 12);
  } else if (hour == 0) {
    hour2 = '12';
  }

  const msg = {
    to: email, // Change to your recipient
    from: 'jmustudyhalls@gmail.com', // Change to your verified sender
    subject: `${username}, ${room_hall} ${room_num} Opening on ${day2} ${month2} ${date} at ${hour2}:${minute < 10 ? '0' + minute : minute} ${timeFrame}`,
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
