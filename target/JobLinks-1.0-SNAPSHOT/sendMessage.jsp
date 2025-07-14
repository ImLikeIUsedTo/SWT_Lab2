<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Gửi tin nhắn</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .chat-container { width: 900px; height: 600px; background-color: #fff; border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); display: flex; overflow: hidden; }
        .sidebar { width: 300px; background-color: #f9f9f9; border-right: 1px solid #eee; display: flex; flex-direction: column; }
        .sidebar-header { background-color: #007bff; color: white; padding: 16px; font-size: 18px; font-weight: bold; }
        .conversation-list { flex: 1; overflow-y: auto; padding: 10px; }
        .conversation-item { padding: 12px; border-bottom: 1px solid #eee; cursor: pointer; transition: background-color 0.2s; }
        .conversation-item:hover { background-color: #e9ecef; }
        .conversation-item.selected { background-color: #e0e7ff; }
        .conversation-item .latest-message { font-size: 12px; color: #666; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .conversation-item .latest-message.unread { font-weight: bold; color: #333; }
        .search-bar { padding: 10px; border-top: 1px solid #eee; }
        .search-bar input { width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 8px; transition: border-width 0.2s; }
        .chat-box { flex: 1; display: flex; flex-direction: column; }
        .chat-header { background-color: #007bff; color: white; padding: 16px; font-size: 18px; font-weight: bold; }
        .chat-content { flex: 1; padding: 16px; overflow-y: auto; font-size: 14px; }
        .message { margin-bottom: 8px; padding: 6px 10px; border-radius: 10px; max-width: 60%; word-wrap: break-word; font-size: 13px; border: 0.5px solid #ddd; position: relative; }
        .message.sent { background-color: #007bff; color: white; margin-left: auto; text-align: right; border-color: #0056b3; }
        .message.received { background-color: #e9ecef; color: #333; margin-right: auto; text-align: left; border-color: #ccc; }
        .message .timestamp { font-size: 0.7em; color: #888; display: block; margin-top: 2px; }
        .message .delete-btn { display: none; position: absolute; top: 2px; right: 2px; background-color: #ff4d4d; color: white; border: none; border-radius: 50%; width: 18px; height: 18px; font-size: 12px; cursor: pointer; line-height: 18px; text-align: center; }
        .message.sent:hover .delete-btn { display: block; }
        .message .delete-btn:hover { background-color: #e60000; }
        .form-group { margin-bottom: 10px; }
        .form-group label { display: block; margin-bottom: 4px; font-weight: bold; color: #333; }
        .form-group input { width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #ccc; font-size: 14px; transition: border-width 0.2s; }
        .chat-footer { border-top: 1px solid #eee; padding: 12px; background-color: #f9f9f9; }
        .chat-footer form { display: flex; gap: 8px; }
        .chat-footer textarea { flex: 1; padding: 10px; border-radius: 20px; border: 1px solid #ccc; resize: none; height: 40px; font-size: 14px; transition: border-width 0.2s; }
        .send-btn { background-color: #007bff; color: white; border: none; padding: 0 20px; border-radius: 20px; font-weight: bold; cursor: pointer; }
        .send-btn:hover { background-color: #0056b3; }
        .error { color: red; text-align: center; margin: 10px; }
    </style>
</head>
<body>
<div class="chat-container">
    <%@include file="header.jsp" %>
    
    <!-- Sidebar: Danh sách tất cả user với thanh tìm kiếm -->
    <div class="sidebar">
        <div class="sidebar-header">Hộp thư</div>
        <div class="conversation-list">
            <c:if test="${empty allUsers}">
                <p>Chưa có người dùng nào.</p>
            </c:if>
            <c:forEach var="user" items="${allUsers}">
                <a href="sendMessage?receiverId=${user.userId}" style="text-decoration: none; color: inherit;">
                    <div class="conversation-item ${user.userId == selectedReceiverId ? 'selected' : ''}">
                        <p><strong>${user.fullName}</strong> (ID: ${user.userId})</p>
                        <c:if test="${not empty user.latestMessage}">
                            <p class="latest-message ${user.senderId != sessionScope.user.userId && !user.hasViewed ? 'unread' : ''}">
                                <c:choose>
                                    <c:when test="${user.senderId == sessionScope.user.userId}">
                                        Bạn: ${user.latestMessage}
                                    </c:when>
                                    <c:otherwise>
                                        ${user.latestMessage}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </c:if>
                    </div>
                </a>
            </c:forEach>
        </div>
        <div class="search-bar">
            <form action="sendMessage" method="get">
                <input type="text" name="searchQuery" placeholder="Tìm tên người dùng..." value="${param.searchQuery}">
            </form>
        </div>
    </div>

    <!-- Chat box: Hiển thị tin nhắn -->
    <div class="chat-box">
        <div class="chat-header">
            Gửi tin nhắn
            <a href="${pageContext.request.contextPath}/home" style="float: right; color: white; text-decoration: none; font-size: 14px;">⬅ Quay về trang chủ</a>
        </div>
        <div class="chat-content">
            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <c:if test="${empty messages}">
                <p>Chưa có tin nhắn nào. Hãy gửi tin nhắn đầu tiên!</p>
            </c:if>
            <c:forEach var="message" items="${messages}">
                <div class="message ${message.senderId == sessionScope.user.userId ? 'sent' : 'received'}">
                    <p>${message.message}</p>
                    <span class="timestamp"><fmt:formatDate value="${message.sentAt}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                    <c:if test="${message.senderId == sessionScope.user.userId}">
                        <form action="sendMessage" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="messageId" value="${message.messageId}">
                            <input type="hidden" name="receiverId" value="${selectedReceiverId}">
                            <button type="submit" class="delete-btn">X</button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <div class="chat-footer">
            <c:if test="${not empty selectedReceiverId}">
                <form action="sendMessage" method="post">
                    <input type="hidden" name="receiverId" value="${selectedReceiverId}">
                    <textarea name="message" placeholder="Nhập tin nhắn..." required></textarea>
                    <button class="send-btn" type="submit">Gửi</button>
                </form>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Cuộn xuống dưới cùng của chat-content
    var chatContent = document.querySelector('.chat-content');
    chatContent.scrollTop = chatContent.scrollHeight;

    // Tìm kiếm chỉ khi nhấn Enter
    var searchInput = document.querySelector('.search-bar input');
    if (searchInput) {
        searchInput.addEventListener('keydown', function(event) {
            if (event.key === 'Enter' || event.keyCode === 13) {
                this.form.submit();
            }
        });

        // Gửi form khi input trở thành rỗng (sau khi xóa)
        searchInput.addEventListener('input', function() {
            if (this.value.trim() === '') {
                this.form.submit();
            }
        });
    }
</script>
</body>
</html>