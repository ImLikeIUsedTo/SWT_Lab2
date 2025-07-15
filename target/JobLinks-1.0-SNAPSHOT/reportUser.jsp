<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Báo cáo người dùng</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    body {
        background-color: #f0f4f8;
        margin: 0;
    }
    .main-content1 {
        padding: 30px 20px;
        margin-top: 140px;
    }
    .report-container1 {
        display: flex;
        justify-content: center;
        padding-bottom: 50px;
    }
    .report-form-wrapper1 {
        width: 100%;
        max-width: 700px;
        background: #ffffff;
        border-radius: 12px;
        padding: 35px 40px;
        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.05);
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
    .report-form-wrapper1 h2 {
        margin-bottom: 10px;
        color: #1e293b;
        font-size: 24px;
        text-align: center;
    }
    .report-form-wrapper1 label {
        font-weight: 600;
        margin-bottom: 5px;
    }
    .report-form-wrapper1 input[type="text"],
    .report-form-wrapper1 select,
    .report-form-wrapper1 textarea {
        width: 100%;
        padding: 12px 14px;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        font-size: 15px;
        background-color: #f9fafb;
        box-sizing: border-box;
        resize: vertical;
    }
    .report-form-wrapper1 textarea {
        min-height: 120px;
    }
    .report-form-wrapper1 button {
        width: 100%;
        background-color: #0ea5e9;
        color: white;
        padding: 12px 0;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 16px;
        transition: background-color 0.3s ease;
    }
    .report-form-wrapper1 button:hover {
        background-color: #0284c7;
    }
    .message {
        text-align: center;
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 6px;
    }
    .error {
        color: #dc3545;
        background-color: #f8d7da;
    }
    .success {
        color: #28a745;
        background-color: #d4edda;
    }
    .dropdown-section {
        margin-bottom: 15px;
    }
    .report-form-wrapper1 select {
        height: 50px;
        overflow-y: auto;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='gray' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 10px center;
        padding-right: 30px;
    }
    .hidden {
        display: none;
    }
    .input-group {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .search-button {
        padding: 10px 15px;
        font-size: 14px;
        width: auto;
        height: 46px;
    }
    .searchable-select {
        position: relative;
    }
    .searchable-select input {
        width: 100%;
        padding-right: 30px;
    }
    .searchable-select select {
        position: absolute;
        top: 100%;
        width: 100%;
        max-height: 200px;
        overflow-y: auto;
        z-index: 10;
        display: none;
    }
    .searchable-select.focused select {
        display: block;
    }
  </style>
</head>
<body>
<%@include file="header-layout.jsp" %>
<div class="main-content1">
  <div class="report-container1">
    <div class="report-form-wrapper1">
      <h2><i class="fas fa-flag"></i> Báo cáo người dùng</h2>
      
      <c:if test="${not empty errorMessage}">
        <div class="message error">${errorMessage}</div>
      </c:if>
      <c:if test="${not empty successMessage}">
        <div class="message success">${successMessage}</div>
      </c:if>

      <form action="${pageContext.request.contextPath}/reportUser" method="post" id="reportForm">
        <div id="reportedUserSection">
          <label for="reportedUser1">Tên người bị tố cáo:</label>
          <div class="input-group">
            <input type="text" id="reportedUser1" name="reportedUser" value="${param.reportedUser}" required>
            <button type="submit" name="action" value="searchUsers" class="search-button">Tìm kiếm</button>
          </div>
        </div>

        <c:if test="${not empty matchingUsers}">
          <div id="userDropdownSection" class="dropdown-section">
            <label for="selectedUserId">Chọn người bạn muốn tố cáo:</label>
            <select name="selectedUserId" id="selectedUserId" onchange="showReportSection()">
              <option value="">-- Chọn người --</option>
              <c:forEach var="user" items="${matchingUsers}">
                <option value="${user.userId}">${user.fullName} (ID: ${user.userId})</option>
              </c:forEach>
            </select>
          </div>
        </c:if>

        <div id="taskSection" class="dropdown-section">
          <label for="taskId1">Task liên quan (nếu có):</label>
          <select name="taskId" id="taskId1">
            <option value="">-- Chọn task --</option>
            <c:forEach var="task" items="${taskList}">
              <option value="${task.taskId}" ${param.taskId == task.taskId ? 'selected' : ''}>
                ${task.title}
              </option>
            </c:forEach>
          </select>
        </div>

        <div id="reasonSection">
          <label for="reason1">Lý do báo cáo:</label>
          <select id="reason1" name="reason" required>
            <option value="">-- Chọn lý do --</option>
            <option value="scam" ${param.reason == 'scam' ? 'selected' : ''}>Lừa đảo / Không đúng với thông tin</option>
            <option value="fake" ${param.reason == 'fake' ? 'selected' : ''}>Giả mạo thông tin</option>
            <option value="abuse" ${param.reason == 'abuse' ? 'selected' : ''}>Lăng mạ / Hành vi không phù hợp</option>
            <option value="other" ${param.reason == 'other' ? 'selected' : ''}>Khác</option>
          </select>
        </div>

        <div id="detailsSection">
          <label for="details1">Mô tả chi tiết:</label>
          <textarea id="details1" name="details" placeholder="Nhập chi tiết về hành vi bạn muốn báo cáo..." required>${param.details}</textarea>
        </div>

        <button type="submit" name="action" value="submitReport"><i class="fas fa-paper-plane"></i> Gửi báo cáo</button>
      </form>
    </div>
  </div>
</div>
<%@ include file="footer.jsp" %>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const reportedUserInput = document.getElementById('reportedUser1');
    const form = document.getElementById('reportForm');
    const userDropdown = document.getElementById('selectedUserId');
    const taskSearchInput = document.getElementById('taskSearch');
    const taskSelect = document.getElementById('taskId1');
    const taskSection = document.querySelector('.searchable-select');

    // Validate name on input
    reportedUserInput.addEventListener('input', () => {
      const name = reportedUserInput.value;
      const isValid = name.trim().length > 0 && !/^\s+$/.test(name);
      reportedUserInput.setCustomValidity(isValid ? '' : 'Vui lòng nhập tên hợp lệ.');
    });
</script>
</body>
</html>