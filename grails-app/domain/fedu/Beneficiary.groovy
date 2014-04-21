package fedu

class Beneficiary {

    /*
     * It might sound counter-intuitive that Beneficiary belongsTo Project.
     * Since a Beneficiary is only created "when" a Project is created, it
     * is right that Beneficiary belongsTo Project.
     */
    static belongsTo = [
        project: Project
    ]

    String firstName
    String lastName
    String email
    String telephone
    Gender gender

    /* Address */
    String addressLine1
    String addressLine2
    String city
    String stateOrProvince
    String postalCode
    String country

    static constraints = {
        firstName nullable: true
        lastName nullable: true
        email blank: false, email: true, nullable: true
        telephone nullable: true
        gender nullable: true

        addressLine1 nullable: true
        addressLine2 nullable: true
        city nullable: true
        stateOrProvince nullable: true
        postalCode nullable: true
        country nullable: true
    }

    enum Gender {
        MALE,
        FEMALE,
        UNSPECIFIED
    }


}
