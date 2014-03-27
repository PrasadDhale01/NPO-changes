import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler

// Place your Spring DSL code here
beans = {
    facebookRedirectFailureHandler(SimpleUrlAuthenticationFailureHandler) {
        defaultFailureUrl = '/facebookauthfailure'
    }
}
