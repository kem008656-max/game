# Sử dụng Ubuntu làm hệ điều hành nền tảng
FROM ubuntu:22.04

# Tránh bị hỏi các câu hỏi cấu hình khi cài đặt phần mềm
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật hệ thống và cài đặt giao diện đồ họa nhẹ cùng trình duyệt Firefox/Chromium để xem YouTube
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    novnc \
    websockify \
    firefox \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Cấu hình cổng kết nối cho NoVNC (để truy cập máy ảo trực tiếp qua trình duyệt web)
EXPOSE 8080

# Lệnh khởi chạy giao diện khi máy ảo bật lên
CMD ["bash", "-c", "vncserver :1 -geometry 1280x720 -depth 24 && websockify --web=/usr/share/novnc/ 8080 localhost:5901"]
