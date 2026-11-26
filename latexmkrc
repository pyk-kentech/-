# Overleaf 의 컴파일러 메뉴가 pdfLaTeX 로 남아 있어도 XeLaTeX 로 컴파일되게 한다.
# 이 논문의 글꼴(Times 계열)과 수식 글꼴은 XeLaTeX 에서만 설정된다(kentech.tex 의 \ifXeTeX).
# pdfLaTeX 로 돌면 Computer Modern 으로 찍히고 쪽수와 그림 배치가 달라진다(2026-11-26 확인).
$pdflatex = 'xelatex %O %S';
