# Koding Global Virtual Hackathon's Submission for Track Room project from ITBeaver

## Description

[![Koding Hackathon](http://memoris.koding.io/images/badge.png "Koding Hackathon")](https://koding.com/Hackathon)

TrackRoom project allows people to communicate in different languages and understand each other better. Users can communicate through correspondence, as well as live online communication (audio-video). The system will try to recognize all the above parties, as well as to translate into additional languages, if in a dialogue involving foreign-language users. Summarized dialogue communication is stored on the server and can be discharged in a txt file. Using archive dialogue will be easier to find and remember the key points of the conversation. At this point, the application TrackRoom available to all users without registration and money. Although there are some limitations, so for example, the recording mode with voice text is only available in the browser Chrome, and the mode of communication in the audio-video mode only in modern browsers.

If you want more security please use HTTPS!!!

## Team
*Aleksander Bobrov*
- Inspirer, project manager, team leader, configure, and deploy applications to the web server
- Implementation of real-time chat

*Nikolay Zykov*
- Implementation of functional multilingualism and translation
- Implementation of functional messaging server

*Sergey Pyankov*
- Layout and design of the project
- Connecting WebRTC TURN, STUN servers
- SSL security via HTTPS and nginx(self signed certificate)

*Artem Russkikh*
- Setting the functional of speech-to-text
- Connecting and configuring WebRTC

Also, each team member was directly involved in the design of applications, discussion and assistance in the implementation of another, adding different features and commits.

## Screenshots Track Room

![Screen shoot 1](http://memoris.koding.io/images/screenshot1.png "Koding")
![Screen shoot 2](http://memoris.koding.io/images/screenshot2.png "Koding")
![Screen shoot 3](http://memoris.koding.io/images/screenshot3.png "Koding")
![Screen shoot 4](http://memoris.koding.io/images/screenshot4.png "Koding")
![Screen shoot 5](http://memoris.koding.io/images/screenshot5.png "Koding")

## Technology stack
 - Web Speech API - OCR for later translation
- Bing Translation API - Translations of text resulting from the OCR module or written by users in chat
- WebRTC - audio-video interaction between the users browsers
- Meteor.js - the basis of real-time applications

Provide a list of APIs you used in this project.
