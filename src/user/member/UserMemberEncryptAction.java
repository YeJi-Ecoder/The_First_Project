package user.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import board.db.BoardDAO;
import user.db.UserDAO;


public class UserMemberEncryptAction implements Action {
	public static final int KEY_SIZE = 2048;
	public static Cipher cipher;
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("도착!");
// 암호화
		HttpSession session = request.getSession();
		ActionForward forward = new ActionForward();
		KeyPairGenerator generator;
		String url = "/login.jsp";
		
		try {
			generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(KEY_SIZE);
			
			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			cipher = Cipher.getInstance("RSA");
			
			/** 새로운 키값을 가진 RSA 생성 **/
			KeyPair keyPair = generator.genKeyPair();
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			// 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
			session.setAttribute("__rsaPrivateKey__", privateKey);
			
			// 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			
			request.setAttribute("publicKeyModulus", publicKeyModulus);
			request.setAttribute("publicKeyExponent", publicKeyExponent);
			
			forward.setRedirect(true);
			forward.setPath(url);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return forward;
	}
}
