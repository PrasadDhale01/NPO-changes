package fedu

import grails.transaction.Transactional

class ImageUrlService {

    	
	@Transactional
	def bootstrap() {
		new ImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Anusuya.png'
		).save(failOnError: true)
		new ImageUrl(
				url: 'https://1.bp.blogspot.com/-tn9GwuoC45w/TvtQvP6_UFI/AAAAAAAAAHI/ECpLGjyH6AI/s1600/machine_learning_course.png'
		).save(failOnError: true)
	}
}
