<?php

declare(strict_types=1);

namespace App\Http\Requests\Customer;

use App\Http\Requests\BaseFormRequest;
/**
 * App\Models\Product
 * @property int $quantity
 */

/**
 * @OA\Schema(
 *     schema="UpdateCartItemRequest",
 *     type="object",
 *     required={"quantity"},
 *     @OA\Property(
 *         property="quantity",
 *         type="integer",
 *         minimum=0,
 *         maximum=100,
 *         example=3,
 *         description="Số lượng sản phẩm (0 để xóa khỏi giỏ)"
 *     )
 * )
 */
class UpdateCartItemRequest extends BaseFormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'quantity' => 'required|integer|min:0|max:100',
        ];
    }

    /**
     * Get custom messages for validator errors.
     */
    public function messages(): array
    {
        return [
            'quantity.required' => 'Quantity is required',
            'quantity.min' => 'Quantity must be at least 0',
            'quantity.max' => 'Quantity cannot exceed 100',
        ];
    }
}
