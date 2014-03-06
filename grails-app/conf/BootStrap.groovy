import fedu.Blog

class BootStrap {

	def init = { servletContext ->
		// Check whether blogs already exist, and create otherwise.
		if (Blog.count() == 0) {
			new Blog(
					title: 'I FEDU for the Future',
					author: 'Anina Tweed',
					date: 'Mar 4',
					snippet: 'I took up my position in the back of the tiny, sweating room ready to hear my students, a group of young women from across South and Southeast Asia, read the personal stories they had worked all semester to create.',
					content: 'I took up my position in the back of the tiny, sweating room ready to hear my students, a group of young women from across South and Southeast Asia, read the personal stories they had worked all semester to create. A cluster of lanky, awkward Bengali boys stumbled in and crowded onto the floor in front of the girls. Their composed, stately fathers lined the back. I looked around nervously, wondering how these men would receive a collection of stories depicting what it is to be a young woman in South Asia. I wondered whether our giggling girls could compose themselves and convey their stories as women. As the first few students read, quivering at first and then building strength, I realized that the audience was surprisingly receptive. By the time the fourth student knelt in front, she belted her opening line proudly: “My body has never embarrassed me.” Dressed in a shocking orange and fuchsia salwaar kameez, she stood out amidst the sea of black men’s blazers, her appearance matching her bold statements. The girls took their turns, telling the audience what it felt like to lose a cousin, to be a girl in a physical education class, to learn English, to decide to leave your country, to experience freedom, to struggle for education, and to have all the weight of your mother’s dreams upon you. They were all at once hilarious, heart-breaking, brave and shy. At the end of the reading, the audience of men clapped and fell silent. One of the gangly boys raised his hand shyly, eyes wide, and whispered “you girls are an inspiration.” Over the course of the semester, I witnessed my students turn from fearful, reluctant writers, certain that they had no narrative worth listening to, to powerful storytellers. Most of them wouldn’t have been able to access a higher education without the scholarships provided to them and shuddered to think of what their lives would be like had they not had the opportunity to attend university. They transformed from young women certain that their futures held only marriage and child-bearing, to leaders with grand plans to found their own NGOs, become parliamentarians, and create economic opportunity in their communities. I FEDU for them. I FEDU so that no one fears for their futures or imagines a life they could have had if they’d just been given the chance. After witnessing firsthand the impact education has on those determined to receive it, I’m excited to join FEDU in connecting new students to the education they need. While we may not all be born with equal access to opportunity, we can certainly work together to lower those barriers and empower education for all.'
					).save(failOnError: true)
			new Blog(
					title: '(Semi) Required Reading',
					author: 'Reece Soltani',
					date: 'Mar 3',
					snippet: 'Here at FEDU, we come across a ton of new and interesting articles. We wanted pass along some of the most recent ones.',
					content: 'Here at FEDU, we come across a ton of new and interesting articles. We wanted pass along some of the most recent ones.'
					).save(failOnError: true)
			new Blog(
					title: 'The Tricky Issue of Causation',
					author: 'FEDU Editorial',
					date: 'Feb 26',
					snippet: 'At FEDU, our focus is on higher education and funding, but those are really just two pieces of the larger education conversation.',
					content: 'At FEDU, our focus is on higher education and funding, but those are really just two pieces of the larger education conversation.'
					).save(failOnError: true)
			new Blog(
					title: 'Day 1 at FEDU',
					author: 'Andrew Koved',
					date: 'Feb 24',
					snippet: 'My idea of the typical startup is jeans, more laptops than known what to do with, and enough coffee to fill a swimming pool. And sure enough, at my first all-hands meeting at FundEdu, there were jean-wearing, laptop-toting people bounding towards the coffee machines.',
					content: 'My idea of the typical startup is jeans, more laptops than known what to do with, and enough coffee to fill a swimming pool. And sure enough, at my first all-hands meeting at FundEdu, there were jean-wearing, laptop-toting people bounding towards the coffee machines.'
					).save(failOnError: true)
			new Blog(
					title: 'The Power of In-Person',
					author: 'FEDU Editorial',
					date: 'Feb 23',
					snippet: 'We all live in an online world, attached to the hip to our computers and iPhones. The internet has facilitated communication at an unprecedented level, and we are all better off for this advance.',
					content: 'We all live in an online world, attached to the hip to our computers and iPhones. The internet has facilitated communication at an unprecedented level, and we are all better off for this advance.'
					).save(failOnError: true)
			new Blog(
					title: 'Thank You\'s',
					author: 'FEDU Editorial',
					date: 'Feb 20',
					snippet: 'Starting a business is hard. Start a business where you are creating a new way of looking at the world? That is even harder. FundEDU is grateful to all of the people who have helped make our work up to this point possible. The support, the listening, the time; all of it has made a difference.',
					content: 'Starting a business is hard. Start a business where you are creating a new way of looking at the world? That is even harder. FundEDU is grateful to all of the people who have helped make our work up to this point possible. The support, the listening, the time; all of it has made a difference.'
					).save(failOnError: true)
		}
	}
	def destroy = {
	}
}
