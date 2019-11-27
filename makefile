default: github-stars

github-stars:
	stars --ext org --outFile apps.org --username danielpza

.PHONY: default github-stars
