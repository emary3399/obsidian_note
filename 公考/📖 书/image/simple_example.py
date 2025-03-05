import requests
from bs4 import BeautifulSoup

def track_package(tracking_number):
    # 17Track的查询页面URL
    url = f"https://www.17track.net/zh-cn/track?nums={tracking_number}"
    
    # 发送GET请求
    response = requests.get(url)
    
    # 检查请求是否成功
    if response.status_code == 200:
        # 使用BeautifulSoup解析HTML
        soup = BeautifulSoup(response.text, "html.parser")
        
        # 提取物流信息（根据实际网页结构调整）
        result = soup.find("div", class_="tracking-result")  # 假设物流信息在这个div中
        if result:
            return result.text.strip()
        else:
            return "未找到物流信息。"
    else:
        print(f"请求失败，状态码：{response.status_code}")
        return None

if __name__ == "__main__":
    # 输入物流单号
    tracking_number = input("请输入物流单号：")
    
    # 查询物流信息
    result = track_package(tracking_number)
    
    # 输出查询结果
    print("物流信息：")
    print(result)