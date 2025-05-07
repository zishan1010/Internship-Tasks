const questions = [
    {
      question: "Who is known as the Father of the Indian Constitution?",
      options: ["Mahatma Gandhi", "Jawaharlal Nehru", "B. R. Ambedkar", "Sardar Patel"],
      answer: "B. R. Ambedkar"
    },
    {
      question: "Which planet is known as the Red Planet?",
      options: ["Earth", "Mars", "Jupiter", "Venus"],
      answer: "Mars"
    },
    {
      question: "Which is the largest ocean in the world?",
      options: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
      answer: "Pacific Ocean"
    },
    {
      question: "In which year did India gain independence?",
      options: ["1942", "1945", "1947", "1950"],
      answer: "1947"
    },
    {
      question: "Who discovered gravity?",
      options: ["Albert Einstein", "Isaac Newton", "Galileo Galilei", "Stephen Hawking"],
      answer: "Isaac Newton"
    }

  ];
  
  
  let currentIndex = 0;
  let score = 0;
  let timer;
  let timeLeft = 15;
  
  function showRules() {
    const modal = new bootstrap.Modal(document.getElementById('rulesModal'));
    modal.show();
  }
  
  function startQuiz() {
    document.querySelector('.container.mt-5').classList.add('d-none');
    document.getElementById('quiz-container').classList.remove('d-none');
    loadQuestion();
  }
  
  function loadQuestion() {
    resetTimer();
    const q = questions[currentIndex];
    document.getElementById('qno').textContent = currentIndex + 1;
    document.getElementById('question').textContent = q.question;
    document.getElementById('feedback').textContent = "";
  
    const optionsContainer = document.getElementById('options');
    optionsContainer.innerHTML = "";
  
    q.options.forEach(option => {
      const btn = document.createElement("button");
      btn.className = "btn btn-outline-primary d-block mb-2 w-100";
      btn.textContent = option;
      btn.onclick = () => checkAnswer(btn, q.answer);
      optionsContainer.appendChild(btn);
    });
  
    startTimer();
  }
  
  function checkAnswer(button, correct) {
    stopTimer();
    const allButtons = document.querySelectorAll("#options button");
    allButtons.forEach(btn => btn.disabled = true);
  
    if (button.textContent === correct) {
      score++;
      document.getElementById("feedback").textContent = "Correct!";
      document.getElementById("feedback").className = "text-success fw-bold mt-3";
    } else {
      document.getElementById("feedback").textContent = `Wrong! Correct Answer: ${correct}`;
      document.getElementById("feedback").className = "text-danger fw-bold mt-3";
    }
  
    setTimeout(() => {
      currentIndex++;
      if (currentIndex < questions.length) {
        loadQuestion();
      } else {
        showResult();
      }
    }, 1500);
  }
  
  function showResult() {
    document.getElementById("quiz-container").classList.add("d-none");
    document.getElementById("result-container").classList.remove("d-none");
    document.getElementById("score").textContent = score;
    document.getElementById("total").textContent = questions.length;
  }
  
  function restartQuiz() {
    currentIndex = 0;
    score = 0;
    document.getElementById("result-container").classList.add("d-none");
    document.getElementById("quiz-container").classList.remove("d-none");
    loadQuestion();
  }
  
  function exitQuiz() {
    location.reload();
  }
  
  function startTimer() {
    timeLeft = 15;
    document.getElementById("timer").textContent = timeLeft;
    timer = setInterval(() => {
      timeLeft--;
      document.getElementById("timer").textContent = timeLeft;
      if (timeLeft === 0) {
        stopTimer();
        autoDisableOptions();
      }
    }, 1000);
  }
  
  function stopTimer() {
    clearInterval(timer);
  }
  
  function resetTimer() {
    stopTimer();
    timeLeft = 15;
    document.getElementById("timer").textContent = timeLeft;
  }
  
  function autoDisableOptions() {
    const buttons = document.querySelectorAll("#options button");
    buttons.forEach(btn => btn.disabled = true);
    document.getElementById("feedback").textContent = "Time's up!";
    document.getElementById("feedback").className = "text-danger fw-bold mt-3";
  
    setTimeout(() => {
      currentIndex++;
      if (currentIndex < questions.length) {
        loadQuestion();
      } else {
        showResult();
      }
    }, 1500);
  }
  