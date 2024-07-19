<%@page import="com.mbc.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   MemberDTO dto = (MemberDTO)request.getAttribute("dto");
%>    
<%@ include file="../include/header.jsp" %> 
                                                       
    <div class='container w-50 shadow mt-5 p-5 rounded-3 border'>                                                               
    <h2>회원 정보</h2>                                                                        
    <form action='memberUpdate.do' method='post'>          
       <input type='hidden' name='no' value='<%=dto.getNo()%>'>                                 
                                        
          <table class='table table-borderless'>
             <thead>
                    <th colspan='2'><h3 class='text-center'><%=dto.getName()%>"님 회원정보 </h3>                                         
              </thead>                                                                             
             <tr>                                                                                          
                <td>번호</td>                                                                             
                <td><input class='form-control' type='text' name='no' value='<%=dto.getNo()%>' disabled /></td>
             </tr>                                                                                        
             <tr>                                                                                         
                <td>아이디</td>                                                                          
                <td><input class='form-control' type='text' name='id' value='<%=dto.getId()%>' disabled /></td>                                                                                  
             </tr>                                                                                      
             <tr>                                                                                       
                <td>비밀번호</td>                                                                      
                <td><input class='form-control' type='text' name='pw' value='<%=dto.getPw()%>' disabled /></td>                                                                                  
             </tr>                                                                                         
             <tr>                                                                                          
                <td>이름</td>                                                                             
                <td><input class='form-control' type='text' name='name' value='<%=dto.getName()%>' disabled /></td>                                                                                  
             </tr>                                                                                        
             <tr>                                                                                         
                <td>나이</td>                                                                            
                <td><input class='form-control' type='text' name='age' value='<%=dto.getAge()%>'/></td>   
             </tr>                                                                                        
             <tr>                                                                                         
                <td>이메일</td>                                                                          
                <td><input class='form-control' type='text' name='email' value='<%=dto.getEmail()%>'/></td> 
             </tr>                                                                                          
             <tr>                                                                                        
                <td>전화번호</td>                                                                       
                <td><input class='form-control' type='text' name='tel' value='<%=dto.getTel()%>'/></td>  
             </tr>                                                                                    
             <tr>                                                                                     
                <td colspan='2' class='text-center p-4'>                                             
                   <input type='submit' value='수정하기' class='btn btn-primary'>                   
                   <input type='reset' value='취소' class='btn btn-warning'>                        
                   <a href='memberList.do' class='btn btn-info'>리스트</a>                  
                </td>                                                                               
             </tr>                                                                                   
          </table>                                                                      
    </form>                                                    
   </div>                                                   
<%@ include file="../include/footer.jsp" %>