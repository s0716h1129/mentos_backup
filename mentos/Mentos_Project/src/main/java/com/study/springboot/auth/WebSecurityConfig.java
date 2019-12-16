package com.study.springboot.auth;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	@Autowired
	public AuthenticationFailureHandler authenticationFailureHandler;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/").permitAll()
			.antMatchers("/css/**", "/js/**", "/img/**").permitAll()
			.antMatchers("/**").permitAll()
			.antMatchers("/mypage/**").hasAnyRole("MEMBER", "ADMIN")
			.antMatchers("/admin/**").hasAnyRole("ADMIN")
			.anyRequest().authenticated();
		
		http.formLogin()
			.loginPage("/loginForm")
			.loginProcessingUrl("/j_spring_security_check")
			.failureUrl("/loginForm?error")			// default : /login?error
			.defaultSuccessUrl("/")
			.failureHandler(authenticationFailureHandler)
			.usernameParameter("MemberId")	// default : j_username
			.passwordParameter("MemberPw")	// default : j_password
			.permitAll();
		
		http.logout()
			.logoutUrl("/logout")
			.logoutSuccessUrl("/")
			.permitAll();
		
		http.csrf().disable();
	}
	
	@Autowired
	private DataSource dataSource;
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		auth.jdbcAuthentication()
			.dataSource(dataSource)
			.usersByUsernameQuery("select email as userName, password, enabled "
								+ " from member where email = ?")
			.authoritiesByUsernameQuery("select email as userName, member_state as authority "
								+ " from member where email = ?")
			.passwordEncoder(new BCryptPasswordEncoder());
	}
	
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
