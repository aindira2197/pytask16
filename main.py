import re
class Parser:
    def __init__(self, text):
        self.text = text
    def parse_email(self):
        pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
        return re.findall(pattern, self.text)
    def parse_phone_number(self):
        pattern = r'(\d{3}[-\.\s]??\d{3}[-\.\s]??\d{4}|\(\d{3}\)\s*\d{3}[-\.\s]??\d{4}|\d{3}[-\.\s]??\d{4})'
        return re.findall(pattern, self.text)
    def parse_url(self):
        pattern = r'(https?://\S+)'
        return re.findall(pattern, self.text)
    def parse_ip_address(self):
        pattern = r'\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
        return re.findall(pattern, self.text)
    def parse_date(self):
        pattern = r'\b\d{1,2}/\d{1,2}/\d{2,4}\b'
        return re.findall(pattern, self.text)
    def parse_time(self):
        pattern = r'\b\d{1,2}:\d{1,2}:\d{1,2}\b'
        return re.findall(pattern, self.text)
    def parse_credit_card(self):
        pattern = r'\b\d{4}[-.]?\d{4}[-.]?\d{4}[-.]?\d{4}\b'
        return re.findall(pattern, self.text)
text = "Email: example@gmail.com, Phone: 123-456-7890, URL: https://www.example.com, IP: 192.168.1.1, Date: 12/12/2022, Time: 12:12:12, Credit Card: 1234-5678-9012-3456"
parser = Parser(text)
print("Email:", parser.parse_email())
print("Phone Number:", parser.parse_phone_number())
print("URL:", parser.parse_url())
print("IP Address:", parser.parse_ip_address())
print("Date:", parser.parse_date())
print("Time:", parser.parse_time())
print("Credit Card:", parser.parse_credit_card())