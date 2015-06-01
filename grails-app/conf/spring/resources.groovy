import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler
// Place your Spring DSL code here
beans = {
    facebookRedirectFailureHandler(SimpleUrlAuthenticationFailureHandler) {
        defaultFailureUrl = '/facebookauthfailure'
    }
    
    facebookRedirectSuccessHandler(SimpleUrlAuthenticationSuccessHandler) {
        defaultTargetUrl = '/facebookauthsuccess'
    }
}
