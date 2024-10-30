defmodule BoardWeb.ChartHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use BoardWeb, :html

  embed_templates "chart_html/*"

  def kind_detail(item, kinds) do
    assigns = %{item: item, detail: Map.get(kinds, item.kind, "")}

    ~H"""
    <%= assigns[:item].kind %> (<%= assigns[:detail] %>)
    """
  end

  def picker(assigns) do
    ~H"""
    <h3 class="mb-4 font-semibold text-gray-900 dark:text-white">Identification</h3>
    <ul class="items-center w-full text-sm font-medium text-gray-900 bg-white border border-gray-200 rounded-lg sm:flex dark:bg-gray-700 dark:border-gray-600 dark:text-white">
      <li class="w-full border-b border-gray-200 sm:border-b-0 sm:border-r dark:border-gray-600">
        <div class="flex items-center ps-3">
          <input
            id="horizontal-list-radio-license"
            type="radio"
            value=""
            name="list-radio"
            class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-700 dark:focus:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500"
          />
          <label
            for="horizontal-list-radio-license"
            class="w-full py-3 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300"
          >
            Driver License
          </label>
        </div>
      </li>
      <li class="w-full border-b border-gray-200 sm:border-b-0 sm:border-r dark:border-gray-600">
        <div class="flex items-center ps-3">
          <input
            id="horizontal-list-radio-id"
            type="radio"
            value=""
            name="list-radio"
            class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-700 dark:focus:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500"
          />
          <label
            for="horizontal-list-radio-id"
            class="w-full py-3 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300"
          >
            State ID
          </label>
        </div>
      </li>
      <li class="w-full border-b border-gray-200 sm:border-b-0 sm:border-r dark:border-gray-600">
        <div class="flex items-center ps-3">
          <input
            id="horizontal-list-radio-military"
            type="radio"
            value=""
            name="list-radio"
            class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-700 dark:focus:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500"
          />
          <label
            for="horizontal-list-radio-military"
            class="w-full py-3 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300"
          >
            US Military
          </label>
        </div>
      </li>
      <li class="w-full dark:border-gray-600">
        <div class="flex items-center ps-3">
          <input
            id="horizontal-list-radio-passport"
            type="radio"
            value=""
            name="list-radio"
            class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-700 dark:focus:ring-offset-gray-700 focus:ring-2 dark:bg-gray-600 dark:border-gray-500"
          />
          <label
            for="horizontal-list-radio-passport"
            class="w-full py-3 ms-2 text-sm font-medium text-gray-900 dark:text-gray-300"
          >
            US Passport
          </label>
        </div>
      </li>
    </ul>
    """
  end
end
