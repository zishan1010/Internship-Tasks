const recipes = [
    {
      name: "Pancakes",
      ingredients: ["flour", "milk", "eggs"],
      type: "Breakfast",
      image: "https://www.allrecipes.com/thmb/FE0PiuuR0Uh06uVh1c2AsKjRGbc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/21014-Good-old-Fashioned-Pancakes-mfs_002-0e249c95678f446291ebc9408ae64c05.jpg"
    },
    {
      name: "Grilled Cheese",
      ingredients: ["bread", "cheese", "butter"],
      type: "Lunch",
      image: "https://flavor-feed.com/wp-content/uploads/2024/02/Untitled-design-2024-02-26T102112.850.jpg"
    },
    {
      name: "Omelette",
      ingredients: ["eggs", "milk", "onion"],
      type: "Breakfast",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTbnh5a6QOXaIR6FTPQ_XkvuwmZbwvTmuiqQ&s"
    },
    {
      name: "Spaghetti",
      ingredients: ["pasta", "tomato", "meat"],
      type: "Dinner",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEkJhsofs1U4sCOT5HGpNeZQWlUtsA5AXX2w&s"
    },
    {
      name: "Salad",
      ingredients: ["lettuce", "tomato", "cucumber"],
      type: "Lunch",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTcsC1AWJPt9Sp5c2aHrzJ44_4EnoXEDd2xw&s"
    }
  ];
  
  const searchInput = document.getElementById("searchInput");
  const typeFilter = document.getElementById("typeFilter");
  const recipeList = document.getElementById("recipeList");
  
  function displayRecipes(filteredRecipes) {
    recipeList.innerHTML = "";
    if (filteredRecipes.length === 0) {
      recipeList.innerHTML = "<p>No recipes found.</p>";
      return;
    }
    filteredRecipes.forEach(recipe => {
      const card = document.createElement("div");
      card.className = "recipe-card";
      card.innerHTML = `
        <img src="${recipe.image}" alt="${recipe.name}" />
        <div class="info">
          <h3>${recipe.name}</h3>
          <p><strong>Type:</strong> ${recipe.type}</p>
          <p><strong>Ingredients:</strong> ${recipe.ingredients.join(", ")}</p>
        </div>
      `;
      recipeList.appendChild(card);
    });
  }
  
  function filterRecipes() {
    const query = searchInput.value.toLowerCase();
    const selectedType = typeFilter.value;
  
    const filtered = recipes.filter(recipe => {
      const matchesType = selectedType === "All" || recipe.type === selectedType;
      const matchesIngredients = recipe.ingredients.some(ingredient =>
        ingredient.toLowerCase().includes(query)
      );
      return matchesType && matchesIngredients;
    });
  
    displayRecipes(filtered);
  }
  
  searchInput.addEventListener("input", filterRecipes);
  typeFilter.addEventListener("change", filterRecipes);
  
  // Initial display
  displayRecipes(recipes);
  