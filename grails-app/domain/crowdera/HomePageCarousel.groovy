package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class HomePageCarousel {
    
    String imageName
    String imageUrl
    String currentEnv

    static constraints = {
        imageName nullable: true
        imageUrl nullable: true
        currentEnv nullable: true
    }
}
