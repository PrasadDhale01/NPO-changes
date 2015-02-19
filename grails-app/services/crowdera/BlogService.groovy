package crowdera

import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

class BlogService {

    @Transactional
	def bootstrap() {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy")

		new Blog(
				title: 'I FEDU for the Future',
				author: 'Anina Tweed',
				date: dateFormat.parse("03/04/2014"),
				snippet: 'I took up my position in the back of the tiny, sweating room ready to hear my students, a group of young women from across South and Southeast Asia, read the personal stories they had worked all semester to create.',
				content: """\
						<p>I took up my position in the back of the tiny, sweating
							room ready to hear my students, a group of young women from
							across South and Southeast Asia, read the personal stories they
							had worked all semester to create. A cluster of lanky, awkward
							Bengali boys stumbled in and crowded onto the floor in front of
							the girls. Their composed, stately fathers lined the back. I
							looked around nervously, wondering how these men would receive a
							collection of stories depicting what it is to be a young woman in
							South Asia. I wondered whether our giggling girls could compose
							themselves and convey their stories as women.</p>
						<p>As the first few students read, quivering at first and then
							building strength, I realized that the audience was surprisingly
							receptive. By the time the fourth student knelt in front, she
							belted her opening line proudly: “My body has never embarrassed
							me." Dressed in a shocking orange and fuchsia salwaar kameez, she
							stood out amidst the sea of black men’s blazers, her appearance
							matching her bold statements. The girls took their turns, telling
							the audience what it felt like to lose a cousin, to be a girl in
							a physical education class, to learn English, to decide to leave
							your country, to experience freedom, to struggle for education,
							and to have all the weight of your mother’s dreams upon you. They
							were all at once hilarious, heart-breaking, brave and shy. At the
							end of the reading, the audience of men clapped and fell silent.
							One of the gangly boys raised his hand shyly, eyes wide, and
							whispered “you girls are an inspiration."</p>
						<p>Over the course of the semester, I witnessed my students
							turn from fearful, reluctant writers, certain that they had no
							narrative worth listening to, to powerful storytellers. Most of
							them wouldn’t have been able to access a higher education without
							the scholarships provided to them and shuddered to think of what
							their lives would be like had they not had the opportunity to
							attend university. They transformed from young women certain that
							their futures held only marriage and child-bearing, to leaders
							with grand plans to found their own NGOs, become
							parliamentarians, and create economic opportunity in their
							communities.</p>
						<p>I FEDU for them. I FEDU so that no one fears for their
							futures or imagines a life they could have had if they’d just
							been given the chance. After witnessing firsthand the impact
							education has on those determined to receive it, I’m excited to
							join FEDU in connecting new students to the education they need.
							While we may not all be born with equal access to opportunity, we
							can certainly work together to lower those barriers and empower
							education for all.</p>"""
				).save(failOnError: true)

		new Blog(
				title: 'The Tricky Issue of Causation',
				author: 'FEDU Editorial',
				date: dateFormat.parse('02/26/2014'),
				snippet: 'At FEDU, our focus is on higher education and funding, but those are really just two pieces of the larger education conversation.',
				content: """\
							<p>At #FEDU, our focus is on higher education and funding, but those are really
							just two pieces of the larger education conversation.</p>

							<p>As we all know, education is rife with problems, from those that FEDU tackles,
							to those of subsidized lunches, SAT scores, and affirmative action.</p>

							<p>With all of these issues, we struggle to full comprehend the problem and come up with
							adequate solutions because all of the pieces are tangled in an inseparable web. </p>

							<p>A really good piece by Maria Popova titled Sleep and the Teenage Brain is an excellent
							reminder of how despite our best efforts to reduce education into manageable little segments,
							the overlap and interplay is enormous.</p>

							<p>There really is no answer here, no shinning light, rather just an acknowledgement of sorts:
							When tackling such messy issues as education, never assume too much.  The rationale for one
							action may be wholly unrelated to its preceding or next action.</p>

							<p>FEDU is working towards drawing really strong connections between two actions:
							The lack of funding and a reduced access to higher education.  We do know though that plenty
							of other factors exist in this ecosystem and we are trying to address them simultaneously.</p>"""
				).save(failOnError: true)

		new Blog(
				title: 'Day 1 at FEDU',
				author: 'Andrew Koved',
				date: dateFormat.parse('02/24/2014'),
				snippet: 'My idea of the typical startup is jeans, more laptops than known what to do with, and enough coffee to fill a swimming pool. And sure enough, at my first all-hands meeting at FundEdu, there were jean-wearing, laptop-toting people bounding towards the coffee machines.',
				content: """\
							<p>My idea of the typical startup is jeans, more laptops than known what to do with,
							and enough coffee to fill a swimming pool.  And sure enough, at my first all-hands
							meeting at FundEdu, there were jean-wearing, laptop-toting people bounding towards
							the coffee machines.</p>

							<p>I did get one piece wrong though, this is not just a typical startup, this is a group
							of workers building a company that is actually going places.  Amongst all of the
							Silicon Valley ambition, the engineers and developers at FundEDU are dreaming bigger and brighter.
							FundEDU, conveniently shortened to FEDU, is a site for crowdfunding of education, allowing people
							from across the globe to support a fellow denizen’s dream of learning.</p>

							<p>The promise and zeal towards creating change was evident just by talking with my coworkers,
							all of who have fully embraced FEDU’s notion of crowdfinding.  Crowdfinding is the idea that
							all of us can help other people –regardless of location– realize their dreams by funding their
							education.  In a world where everything is connected and aspirations can be realized with
							the click of a button, capital should not remain tethered to a checkbook.</p>

							<p>The constant static of Skype conversations, the shouts from other conference rooms,
							and the animated engineers are all reminders that FEDU is just launching –or that
							we’ve had too much coffee– but this level of energy is commensurate with the scale of FEDU.</p>

							<p>Too often startups emerge locally and then grow out; expanding piece-by-piece, taking time
							to go global.  Not FEDU.  First on the list was India, where our first projects launched
							more than a month ago and was just recently visited by Chet.  FEDU is promising to facilitate
							education around the world, and we have already made a really strong start.</p>

							<p>Having graduated from college this past May, I have spent the majority of life in school;
							in one-way or another, I have been engaged in education for the past decade and a half.
							To understand global inequality is to know that people’s education level is not a choice
							but a statement of fiscal reality, a tough realization for a person who has spent their whole life in academia.</p>

							<p>In taking on the challenges of education, FEDU is committing itself to solving a massive
							problem, and joining a field with many institutional and entrenched organizations.
							The goal of FEDU is to upset the balance of power, where instead of the big charities deciding
							where the money is funneled, individuals can log on and contribute directly to people to a person’s future.
							The launch of FEDU is important because it hands the power back to the average person and allows
							individuals to fund difference making.</p>

							<p>Joining FEDU has been an exciting process, one where moving at a frenetic pace is enjoyable
							because the mission is so clear: Fund Education.  As my first meeting wrapped up, we ended
							on a slide that really captured my concept of FEDU’s mission.  The slide said “Why do we FEDU?
							Because where you live shouldn't determine how you live."</p>"""
				).save(failOnError: true)

		new Blog(
				title: 'The Power of In-Person',
				author: 'FEDU Editorial',
				date: dateFormat.parse('02/23/2014'),
				snippet: 'We all live in an online world, attached to the hip to our computers and iPhones. The internet has facilitated communication at an unprecedented level, and we are all better off for this advance.',
				content: """\
							<p>We all live in an online world, attached to the hip to our computers and iPhones.
							The internet has facilitated communication at an unprecedented level, and we are
							all better off for this advance. </p>

							<p>As an internet startup, FEDU lives and breathes technology and the web.
							Having coworkers at your fingertips enables 24/7 productivity, a marvel of
							our time that too often we under appreciate. </p>

							<p>This all being said, our best work is still done when we sit down at a
							table and talk face to face.  Our Sunday meetings might be a tad frenetic,
							but at the end of the day we are better off for the experience.</p>"""
				).save(failOnError: true)

		new Blog(
				title: 'Thank You\'s',
				author: 'FEDU Editorial',
				date: dateFormat.parse('02/20/2014'),
				snippet: 'Starting a business is hard. Start a business where you are creating a new way of looking at the world? That is even harder. FundEDU is grateful to all of the people who have helped make our work up to this point possible. The support, the listening, the time; all of it has made a difference.',
				content: """\
							<p>Starting a business is hard.  Start a business where you are creating a new
							way of looking at the world? That is even harder.  FundEDU is grateful to all
							of the people who have helped make our work up to this point possible.
							The support, the listening, the time; all of it has made a difference.</p>

							<p>Our head of basically everything Reece sent out this note, along with
							wristbands, to a some integral supporters:</p>

							<p>"Rahul Mohanty, Udeepto Maheshwari, Cambiz Christopher Aliabadi, Munawira Kotyad and
							Franav Frank Pillai are a few of the first pioneers to receive FEDU wristbands and rep
							them within their communities. Join them and ask how you can also join the Instagram
							movement "Enabling Education for All" with FEDU!
							So proud of all you guys and honored to call you friends Thanks for the support thus far!"</p>

							<p>As we are getting off the ground, you'll be sure to hear more of these from the team.</p>"""
				).save(failOnError: true)
	}
}
