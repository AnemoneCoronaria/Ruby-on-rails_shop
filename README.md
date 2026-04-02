
# Ruby on Rails Shop

## 프로젝트 개요
Ruby on Rails 기반 쇼핑몰 프로젝트입니다.  
Rails 8.1.3, Ruby 3.2.3 환경에서 개발되었습니다.

---

## 개발 환경

### 필수 소프트웨어
- Ruby 3.2.3
- Rails 8.1.3
- SQLite (이미 테스트 데이터가 삽입됨)
- Git

### Ubuntu 환경 세팅
```bash
sudo apt update
sudo apt install -y git curl build-essential libssl-dev libreadline-dev zlib1g-dev

# rbenv 설치
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 3.2.3
rbenv global 3.2.3

gem install bundler

cd shop_save
bundle install
rails db:create
rails db:migrate
rails db:seed ...
```

### mac os 환경 세팅
```
brew install rbenv ruby-build
rbenv install 3.2.3
rbenv global 3.2.3
gem install bundler

cd shop_save
bundle install
rails db:create
rails db:migrate
rails db:seed
```

### 프로젝트 실행
```
# 서버 실행
rails server

# 접속 URL
http://localhost:3000
```

### 테스트 계정
```
관리자 계정
이메일: admin@marketo.com
비밀번호: admin123
역할: admin

판매자 계정
이메일: test1@test.com
비밀번호: 123456
역할: seller

일반 사용자 계정
이메일: test2@test.com
비밀번호: 123456

역할: buyer
이메일: test3@test.com
비밀번호: 123456
역할: buyer

```
