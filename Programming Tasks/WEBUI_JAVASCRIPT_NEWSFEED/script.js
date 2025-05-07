let articles = [];
let currentPage = 1;
const articlesPerPage = 4;

function addArticle() {
  const title = document.getElementById('title').value.trim();
  const description = document.getElementById('description').value.trim();
  const imageURL = document.getElementById('imageURL').value.trim();

  if (!title || !description) {
    alert("Title and Description are required.");
    return;
  }

  articles.unshift({ title, description, imageURL }); // Add new article to the beginning
  document.getElementById('title').value = '';
  document.getElementById('description').value = '';
  document.getElementById('imageURL').value = '';

  renderArticles();
  renderPagination();
}

function renderArticles() {
  const start = (currentPage - 1) * articlesPerPage;
  const end = start + articlesPerPage;
  const currentArticles = articles.slice(start, end);

  const newsFeed = document.getElementById('newsFeed');
  newsFeed.innerHTML = '';

  currentArticles.forEach(article => {
    const card = document.createElement('div');
    card.className = 'article-card';

    const image = article.imageURL ? `<img src="${article.imageURL}" alt="Image">` : '';
    card.innerHTML = `
      ${image}
      <h3>${article.title}</h3>
      <p>${article.description}</p>
    `;
    newsFeed.appendChild(card);
  });
}

function renderPagination() {
  const totalPages = Math.ceil(articles.length / articlesPerPage);
  const pagination = document.getElementById('pagination');
  pagination.innerHTML = '';

  const prevBtn = document.createElement('button');
  prevBtn.innerText = 'Previous';
  prevBtn.disabled = currentPage === 1;
  prevBtn.onclick = () => {
    currentPage--;
    renderArticles();
    renderPagination();
  };
  pagination.appendChild(prevBtn);

  for (let i = 1; i <= totalPages; i++) {
    const btn = document.createElement('button');
    btn.innerText = i;
    if (i === currentPage) btn.classList.add('active');
    btn.onclick = () => {
      currentPage = i;
      renderArticles();
      renderPagination();
    };
    pagination.appendChild(btn);
  }

  const nextBtn = document.createElement('button');
  nextBtn.innerText = 'Next';
  nextBtn.disabled = currentPage === totalPages;
  nextBtn.onclick = () => {
    currentPage++;
    renderArticles();
    renderPagination();
  };
  pagination.appendChild(nextBtn);
}


const sampleArticles = [
    {
      title: "US Defense Secretary Hegseth orders 20% cut in senior ranks of military",
      description: "US Secretary of Defense Pete Hegseth arrives for a meeting with Peru's foreign affairs minister, Elmer Schialer, and Peru's defence minister, Walter Astudillo, at the Pentagon in Washington, DC, on May 5, 2025 [Mark Schiefelbein/AP]",
      imageURL: "https://www.aljazeera.com/wp-content/uploads/2025/05/AP25125518131053-1-1746499862.jpg?resize=770%2C513&quality=80"
    },
    {
      title: "Explosions, huge fire in Sudanese city of Port Sudan",
      description: "Drones believed to have been launched by the paramilitary Rapid Support Forces are said to have struck fuel depot causing huge fire: Reports",
      imageURL: "https://www.aljazeera.com/wp-content/uploads/2025/05/2025-05-06T035921Z_282999148_RC23CEAT655F_RTRMADP_3_SUDAN-POLITICS-1746506181.jpg?resize=770%2C513&quality=80"
    },
    {
      title: "Russia-Ukraine war: List of key events, day 1,167",
      description: "Russian attacks on the Donetsk and Sumy regions of eastern Ukraine killed at least three people on Monday, Ukrainian authorities said.",
      imageURL: "https://www.aljazeera.com/wp-content/uploads/2025/05/AFP__20250505__44JE366__v1__HighRes__UkraineRussiaConflictWar-1746506252.jpg?resize=770%2C513&quality=80"
    },
    {
      title: "Manchester United focusing only on Europe: Amorim after suffering record 16th loss in Premier League",
      description: "Manchester United fell to their record 16th loss in the Premier League on Sunday, May 4. Playing against Brentford, United lost 4-3 in what turned out to be a thriller.",
      imageURL: "https://akm-img-a-in.tosshub.com/indiatoday/images/story/202505/ruben-amorim-044956375-16x9_0.jpg?VersionId=zov4btY36MCWXSx.Bd6f.lW5ZtlMYQiN&size=690:388"
    },
    {
        title: "Deadly Floods Hit Brazil’s Rio Grande do Sul State",
        description: "At least 60 people killed and more than 80,000 displaced after heavy rains trigger floods in southern Brazil.",
        imageURL: "https://ichef.bbci.co.uk/news/1024/cpsprodpb/e727/live/5cd6a3e0-0a1b-11ef-bee9-6125e244a4cd.jpg.webp"
      },
      {
        title: "UN Warns of Famine Risk in Sudan as War Escalates",
        description: "The United Nations warns that millions in Sudan are at risk of famine amid ongoing conflict and lack of humanitarian access.",
        imageURL: "https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production%20Library/24-12-2024-UNICEF-Sudan.jpeg/image1170x530cropped.jpg"
      },
      {
        title: "Google Launches New AI-Powered Search Experience",
        description: "Google introduces major updates to its search engine, using AI to generate contextual answers directly in results.",
        imageURL: "https://storage.googleapis.com/gweb-uniblog-publish-prod/images/ai-mode-hero-image.width-1600.format-webp.webp"
      },
      {
        title: "Indonesia's Mount Ruang Erupts, Thousands Evacuated",
        description: "Indonesia’s disaster agency orders evacuations as Mount Ruang spews ash and lava in a dramatic overnight eruption.",
        imageURL: "https://i.guim.co.uk/img/media/f793feca042bafa309852771fbbc61e617385eb8/0_131_4000_2400/master/4000.jpg?width=620&dpr=2&s=none&crop=none"
      },
      {
        title: "Russia Launches Fresh Missile Strikes Across Ukraine",
        description: "Multiple cities across Ukraine report explosions as Russia intensifies its overnight missile campaign.",
        imageURL: "https://i.abcnewsfe.com/a/a4ae173d-a1f7-417e-ab9a-8f7d505df7b2/Kyiv-missile-strike-DB-250406_1743925206528_hpEmbed_3x2.jpg?w=1500"
      },
      {
        title: "China Reports Stronger-Than-Expected Economic Growth",
        description: "China's GDP grows by 5.2% in the first quarter of 2025, beating analyst forecasts amid rising exports.",
        imageURL: "https://static.toiimg.com/thumb/msid-120328773,imgsize-1831357,width-400,resizemode-4/120328773.jpg"
      },
      {
        title: "Kenya Battles Flash Floods After Torrential Rains",
        description: "Heavy rains in Nairobi and surrounding regions leave dozens dead and thousands displaced, officials say.",
        imageURL: "https://www.aljazeera.com/wp-content/uploads/2024/11/2024-11-03T100956Z_1931840068_RC2LXAADB8M6_RTRMADP_3_EUROPE-WEATHER-SPAIN-STORM-1730629449.jpg?resize=770%2C513&quality=80"
      },
      {
        title: "NASA Prepares for Artemis II Moon Mission",
        description: "NASA readies its crew and systems for the historic Artemis II mission, aiming to orbit the Moon by late 2025.",
        imageURL: "https://i0.wp.com/spaceexplored.com/wp-content/uploads/sites/10/2025/05/KSC-20250430-PH-ILW01_0096medium.jpg?w=1500&quality=82&strip=all&ssl=1"
      }
      
  ];
  
articles = sampleArticles;
renderArticles();
renderPagination();
