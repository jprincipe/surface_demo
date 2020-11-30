defmodule SurfaceDemoWeb.ModalComponent do
  use SurfaceDemoWeb, :surface_component

  alias Surface.Components.LivePatch

  prop(title, :string, required: true)
  prop(return_to, :string, required: true)

  @impl true
  def render(assigns) do
    ~H"""
    <div id="{{ @id }}" class="phx-modal"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-page-loading>

      <div class="phx-modal-content">
        <LivePatch label="X" to="{{ @return_to }}" class="phx-modal-close"/>
        <h2>{{ @title }}</h2>
        <slot/>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
