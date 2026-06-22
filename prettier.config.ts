import type { Config } from "prettier";

const config: Config = {
  printWidth: 88,
  tabWidth: 2,
  singleQuote: true,
  trailingComma: "all",
  plugins: ["prettier-plugin-sh"],
  overrides: [
    {
      files: "*.mdc",
      options: {
        parser: "markdown",
      },
    },
  ],
};

export default config;
