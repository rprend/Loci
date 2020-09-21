Universities, schools, corporations, and conferences use our computer vision tools to build digital streetscapes for their community.

Winner HackMIT 2020 in the Communication/Connectivity Track challenge to bring people together, connecting them regardless of their physical locations.

## Inspiration
We talk a lot about Zoom Fatigue, but never of the problem of Zoom Sparsity. A video call is lonely. It is created; it is configured; and then it is destroyed. It exists only as a link 50+ characters long, with subdirectories and IDs and hashes trailing -- meaningless gibberish to humans. 

Why do we maintain this inherently temporary paradigm? It made sense for one-off meetings, but not for much else. And in 2020, video calls transition from a niche to a necessity. They need to work for everyone. 

Zoom sparsity especially challenges organizations, who are trying to translate complex systems into individual, unstructured video calls. We know countless university students, ourselves included, who have spreadsheets just to keep track of the 20+ different links for classes and clubs. I find myself regularly updating mine. And those who don't dedicate the time beforehand are constantly digging through class websites, Piazza, and old emails just for today’s link. 

Dealing with such unstructured, disparate data is hard because the human mind does not think linearly. Our minds are networked and associative, and we intuitively understand and remember that which we represent spatially. Every Grandmaster of Memory credits the Method of Loci for his or her success; they build vast “memory palaces” to perform such feats as memorizing a card deck in 30 seconds. 

So why don’t we organize remote work spatially?

It's been done before. HackMIT built a Playground, a Club Penguin-esque world for hackers to walk talk to other hackers/organizers/sponsors. Stanford built Club Cardinal, a browser game that serves as a social media for its students. And Gather.town tries to bring some of the spontaneity of a house party to meetups and icebreakers. 

But these are singular solutions built to solve singular problems. And they are almost exclusively used at a small scale, as proofs of a concept or a gimmick, rather than as a fundamental feature of the organization itself.

Remote work lacks place. So, we set out to build this sense of place at scale. We developed the tools for any university/company/conference to build its own Playground, its own Club Cardinal, its own Gather.town; we integrate seamless video conferencing so people can join and leave rooms whenever; we use machine learning computer vision to autogenerate these streetscapes; and we leverage cutting edge Urban Design to optimize the places for collaboration. We built Loci.

## What it does
There are two main interfaces in Loci, characterized by the two use cases. The first is a user -- a student or employee or attendee. For them, Loci is a centralized place where they go to do work. Entering a building opens its corresponding video call. Because a video call is tied to a building instead of just a link, it is persistent. Computer science lectures, for example, are always held in the computer science auditorium, while your discussions are at the corner of Broadway and Prospect. Want to meet one on one? Pick out a small house, and that's a meeting room. They are digital streetscapes organized like real campuses.

The second use case is the organizer. For them, Loci is a system of tools for their organization to build and configure streetscapes. They start with a drawing -- either something they've drawn themselves or a floor plan they want to start from. We use IBM Watson & OpenCV computer vision to turn that drawing into a starter city. From there, they can manually add new buildings, drag them around and place them, and edit buildings to change their configurations.

## How We built it
Our project consists of four main components: the frontend app, the backend server, the computer vision scripts, and the streetscape design. 

The frontend app is built in Flutter. There is a view mode, an edit mode, a video calling mode, and all the menus and cards required to effectively navigate between. The view mode is the interface for users, allowing panning and entering of various buildings. They can then join a room and are taken to a video call which they can join. To create the streetscape, organizers used the edit mode, which allows start with a photo to connect our backend computer vision, or 

## Challenges We ran into
Integrations, integrations! Video call communication (none of us are together, and we're spread across three different time zones!)
