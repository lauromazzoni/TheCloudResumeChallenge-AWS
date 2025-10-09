const counter = document.getElementById("visits");
const API_URL = "https://jaotlt9koe.execute-api.us-east-1.amazonaws.com/prod/counter";

async function updateCounter() {
  try {
    const response = await fetch(API_URL);
    const data = await response.json();

    // Aceita tanto body JSON quanto resposta direta
    const parsed = typeof data.body === "string" ? JSON.parse(data.body) : data;
    counter.innerText = parsed.visits ?? "N/A";
  } catch (err) {
    console.error("Erro ao buscar contador:", err);
    counter.innerText = "N/A";
  }
}

updateCounter();




// const counter = document.getElementById("visits");
// const API_URL = "https://m3ezj6hkih.execute-api.us-east-1.amazonaws.com/prod/counter";


// async function updateCounter() {
//   try {
//     let response = await fetch(API_URL);
//     let data = await response.json();

//     // o campo "visits" vem dentro de "body" como string JSON
//     let parsedBody = JSON.parse(data.body);

//     counter.innerText = parsedBody.visits;
//   } catch (err) {
//     console.error("Erro ao buscar contador:", err);
//     counter.innerText = "N/A";
//   }
// }

// updateCounter();

