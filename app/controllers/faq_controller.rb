class FaqController < ApplicationController
  def index
    @faqs = [
      { question: "회원가입은 어떻게 하나요?", answer: "상단 우측의 '회원가입' 버튼을 클릭하여 가입하실 수 있습니다." },
      { question: "상품은 어떻게 검색하나요?", answer: "상단 메뉴의 '전체 상품'에서 키워드나 가격 범위로 검색할 수 있습니다." },
      { question: "배송은 얼마나 걸리나요?", answer: "주문 후 평균 2-3일 소요됩니다. 지역에 따라 차이가 있을 수 있습니다." },
      { question: "환불은 어떻게 하나요?", answer: "문의 게시판에 환불 문의를 남겨주시면 처리해드립니다." },
      { question: "판매자가 되려면 어떻게 하나요?", answer: "푸터의 '판매 시작하기' 버튼을 클릭하여 신청해주세요." }
    ]
  end
end
