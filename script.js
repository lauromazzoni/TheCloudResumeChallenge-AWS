document.addEventListener("DOMContentLoaded", () => {
  // --- Animação das sections ---
  const sections = document.querySelectorAll(".section");

  const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.animationPlayState = "running";
      }
    });
  }, {
    threshold: 0.1
  });

  sections.forEach(section => {
    section.style.animationPlayState = "paused";
    observer.observe(section);
  });

  // --- Contador de visitas ---
  const counter = document.getElementById("visits");
  const apiUrl = "https://SEU-ENDPOINT.execute-api.REGIAO.amazonaws.com/prod/counter";

  async function updateCounter() {
    try {
      let response = await fetch(apiUrl);
      let data = await response.json();
      counter.innerText = data.visits;
    } catch (error) {
      console.error("Erro ao buscar contador:", error);
      counter.innerText = "N/A";
    }
  }

  updateCounter();
});
