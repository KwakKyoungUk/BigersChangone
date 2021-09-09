/*package com.axisj.axboot.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;


public class LoginStore implements HttpSessionBindingListener {

	private static volatile LoginStore loginStore;
    private Map<String, HttpSession> loginSessions;
 
    // private으로 설정
    // 생성자를 호출하지 못하도록 막는다.
    private LoginStore() {
        loginSessions = new HashMap<String, HttpSession>();
    }
 
    public static synchronized LoginStore getInstance() {
 
        if (loginStore == null) {
            loginStore = new LoginStore();
        }
 
        return loginStore;
    }
 
    public void add(String memberId, HttpSession session) {
        loginSessions.put(memberId, session);
    }
 
    public HttpSession get(String memberId) {
        return loginSessions.get(memberId);
    }
 
    public void logout(String memberId) {
        if (loginSessions.containsKey(memberId)) {
            try {
               // loginSessions.get(memberId).invalidate();
            } catch (RuntimeException re) {}
            loginSessions.remove(memberId);
        }
    }

	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		//session값을 put한다.
		
		
    	// loginUsers.put(event.getSession(), event.getName());
	    System.out.println(event.getName() + "님이 로그인 하셨습니다.");
	    System.out.println(event.getSession() + "세션");
	        
		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// TODO Auto-generated method stub
		
	}


}
*/